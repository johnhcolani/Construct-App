import 'package:construct_app/features/project/domain/entities/project.dart';
import 'package:construct_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:construct_app/features/project/presentation/bloc/project_state.dart';
import 'package:construct_app/features/project/presentation/pages/project_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'project_dashboard_page_test.mocks.dart';

@GenerateMocks([ProjectBloc])
void main() {
  late MockProjectBloc mockProjectBloc;

  setUp(() {
    mockProjectBloc = MockProjectBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProjectBloc>(
        create: (_) => mockProjectBloc,
        child: ProjectDashboardPage(),
      ),
    );
  }

  final tProjects = [
    Project(
      id: '1',
      name: 'Burleigh Lot 8 - Willow Cottage - Colani',
      imageUrl: 'https://example.com/image1',
    ),
  ];

  testWidgets('should render loading indicator when state is ProjectLoading',
          (WidgetTester tester) async {
        // Arrange
        when(mockProjectBloc.state).thenReturn(ProjectLoading());
        when(mockProjectBloc.stream).thenAnswer((_) => Stream.value(ProjectLoading()));

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

  testWidgets('should render project details when state is ProjectLoaded',
          (WidgetTester tester) async {
        // Arrange
        when(mockProjectBloc.state).thenReturn(ProjectLoaded(tProjects));
        when(mockProjectBloc.stream).thenAnswer((_) => Stream.value(ProjectLoaded(tProjects)));

        // Act
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pump(); // Trigger the UI rebuild
        });

        // Assert
        expect(find.text('Burleigh Lot 8 - Willow Cottage - Colani'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
        expect(find.text('Overview'), findsOneWidget);
        expect(find.text('Financials'), findsOneWidget);
        expect(find.text('Specs & Selections'), findsOneWidget);
      });

  testWidgets('should render error message when state is ProjectError',
          (WidgetTester tester) async {
        // Arrange
        when(mockProjectBloc.state).thenReturn(ProjectError('Failed to load projects'));
        when(mockProjectBloc.stream)
            .thenAnswer((_) => Stream.value(ProjectError('Failed to load projects')));

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // Assert
        expect(find.text('Failed to load projects'), findsOneWidget);
      });
}