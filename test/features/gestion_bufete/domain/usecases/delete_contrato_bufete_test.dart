import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/repository/contrato_bufete_repository.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/delete_contrato_bufete.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ContratoBufeteRepository])
import 'delete_contrato_bufete_test.mocks.dart';

void main() {
  late MockContratoBufeteRepository mockContratoBufeteRepository;
  late DeleteContratoBufete usecase;

  setUp(() {
    mockContratoBufeteRepository = MockContratoBufeteRepository();
    usecase = DeleteContratoBufete(repository: mockContratoBufeteRepository);
  });
  const bool tBool = true;
  const int tKey = 5;

  test('Comprobando que se Elimina el Contrato Correctamente', () async {
    when(mockContratoBufeteRepository.deleteContratoBufete(any))
        .thenAnswer((realInvocation) async => const Right(tBool));
    final response = await usecase(key: tKey);
    expect(response, const Right(tBool));
    verify(mockContratoBufeteRepository.deleteContratoBufete(tKey));
    verifyNoMoreInteractions(mockContratoBufeteRepository);
  });
}
