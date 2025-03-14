import 'package:construct_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:construct_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:construct_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:construct_app/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';


@GenerateMocks([AuthBloc])
void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (_) => mockAuthBloc,
        child: LoginPage(),
      ),
    );
  }

  testWidgets('should render login page with all elements',
          (WidgetTester tester) async {
        // Arrange
        when(mockAuthBloc.state).thenReturn(AuthInitial());
        when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(AuthInitial()));

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('COCONSTRUCT™'), findsOneWidget);
        expect(find.byType(TextField), findsNWidgets(2));
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Sign In'), findsOneWidget);
        expect(find.text('I forgot my password'), findsOneWidget);
      });

  testWidgets('should dispatch LoginSubmitted event when Sign In is tapped',
          (WidgetTester tester) async {
        // Arrange
        when(mockAuthBloc.state).thenReturn(AuthInitial());
        when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(AuthInitial()));

        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(find.byType(TextField).first, 'test@example.com');
        await tester.enterText(find.byType(TextField).last, 'password');
        await tester.tap(find.text('Sign In'));
        await tester.pump();

        // Assert
        verify(mockAuthBloc.add(LoginSubmitted(
          email: 'test@example.com',
          password: 'password',
        ))).called(1);
      });

  testWidgets('should show SnackBar when AuthFailure state is emitted',
          (WidgetTester tester) async {
        // Arrange
        when(mockAuthBloc.state).thenReturn(AuthFailure('Login failed'));
        when(mockAuthBloc.stream)
            .thenAnswer((_) => Stream.value(AuthFailure('Login failed')));

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(); // Trigger the listener

        // Assert
        expect(find.text('Login failed'), findsOneWidget);
      });
}