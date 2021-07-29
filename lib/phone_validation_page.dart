import 'package:flutter/material.dart';
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatefulWidget {
  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: AppBar(
        title: Text('아임포트 본인인증'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'iamport',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData.fromJson({
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
        'company': '아임포트',                                            // 회사명 또는 URL
        'carrier': 'SKT',                                               // 통신사
        'name': '신승건',                                                 // 이름
        'phone': '01066182864',                                         // 전화번호
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        print(result);
      },
    );
  }
}
