import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/repository/contrato_bufete_repository.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/get_saldo_mes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ContratoBufeteRepository])
import 'get_saldo_mes_test.mocks.dart';

void main() {
  late MockContratoBufeteRepository mockContratoBufeteRepository;
  late GetSaldoMes usecase;

  setUp(() {
    mockContratoBufeteRepository = MockContratoBufeteRepository();
    usecase = GetSaldoMes(repository: mockContratoBufeteRepository);
  });

  const double tSaldo = 500.0;
  const String tMes = 'Enero';

  test('Debe Obtener el saldo del Mes', () async {
    when(mockContratoBufeteRepository.getSaldoMes(any))
        .thenAnswer((_) async => const Right(tSaldo));
    final result = await usecase(mes: tMes);
    expect(result, const Right(tSaldo));
    verify(mockContratoBufeteRepository.getSaldoMes(tMes));
    verifyNoMoreInteractions(mockContratoBufeteRepository);
  });
}
