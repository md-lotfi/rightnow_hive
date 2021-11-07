import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rightnow/components/common_widgets.dart';

import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CguScreen extends StatefulWidget {
  final int? goToDataPrivacy;
  CguScreen({
    Key? key,
    this.goToDataPrivacy,
  }) : super(key: key);

  @override
  _CguScreenState createState() => _CguScreenState();
}

class _CguScreenState extends State<CguScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.goToDataPrivacy != null) {
        _itemScrollController.jumpTo(index: widget.goToDataPrivacy!); //widget.goToDataPrivacy!
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      body: Column(
        children: [
          HeaderBarWidget(builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 40),
              child: Row(
                children: [
                  Image.asset(
                    "assets/axa-logo.png",
                    fit: BoxFit.contain,
                    width: 70,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      "Conditions d'utilisation & Politique de confidentialité".tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: COLOR_PRIMARY,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: _body(context),
          )),
        ],
      ),
    ));
  }

  List<Widget> _data = [
    titleText("Introduction".tr()),
    bodyText(
        "La présente politique de confidentialité décrit les politiques et procédures de Rightnow By Brenco en matière de collecte, d'utilisation et de divulgation de vos informations. Rightnow By Brenco reçoit vos informations par le biais de nos différents sites web, API, services et tiers (Services). En utilisant l'un de nos services, vous consentez à la collecte, au transfert, à la manipulation, au stockage et aux autres utilisations de vos informations, comme décrit dans la présente politique de confidentialité. Indépendamment du pays dans lequel vous résidez ou à partir duquel vous créez des informations, vos informations peuvent être utilisées par Rightnow By Brenco en Algérie ou dans tout autre pays où Rightnow By Brenco opère."
            .tr()),
    SizedBox(height: 15),
    titleText("COLLECTE ET UTILISATION DES INFORMATIONS".tr()),
    bodyText(
        "Informations collectées lors de l'inscription Lorsque vous créez ou reconfigurez un compte Rightnow By Brenco, vous fournissez certaines informations personnelles, telles que votre nom, votre nom d'utilisateur, votre mot de passe et votre adresse e-mail. Informations relatives à la carte de crédit fournies pour les comptes payants Lorsque vous nous fournissez les informations relatives à votre carte de crédit, cette transmission sera protégée par un certificat SSL et stockée dans une installation de stockage conforme à la norme PCI-DSS de niveau 1 (ou équivalent selon les standards en Algérie). Nous ne divulguerons jamais vos informations de paiement à une tierce partie. Informations complémentaires Vous pouvez nous fournir des informations supplémentaires pour nous aider à mieux comprendre ou à mieux répondre à vos besoins. Il peut s'agir d'informations telles que le secteur dans lequel vous travaillez et les tâches pour lesquelles vous utilisez nos services. Informations sur la localisation Vous pouvez choisir d'inclure l'emplacement dans vos soumissions (envoie de formulaires).Informations personnelles Les informations précédentes collectées lors de l'inscription, les informations relatives à la carte de crédit, les informations supplémentaires et les informations de localisation sont collectivement appelées 'informations personnelles' dans la présente politique."
            .tr()),
    SizedBox(height: 15),
    titleText("Données de journal".tr()),
    bodyText(
        "Nos serveurs enregistrent automatiquement les informations (Données du journal) créées par votre utilisation des Services. Ces données peuvent inclure des informations telles que votre adresse IP, votre type de navigateur, le domaine de référence, les pages visitées et les termes de recherche. D'autres actions, telles que les interactions avec les publicités, peuvent également être incluses dans les données du journal."
            .tr()),
    SizedBox(height: 15),
    titleText("Liens".tr()),
    bodyText(
        "Rightnow By Brenco peut garder une trace de la façon dont vous interagissez avec les liens dans nos Services, y compris l'utilisation de connecteurs tiers, en redirigeant les clics ou par d'autres moyens. Cela nous permet d'améliorer nos services et de partager des statistiques globales sur les clics, comme le nombre de fois où un lien particulier a été cliqué."
            .tr()),
    SizedBox(height: 15),
    titleText("Cookies".tr()),
    bodyText(
        "Comme de nombreux sites web, nous utilisons la technologie des 'cookies' pour collecter des données supplémentaires sur l'utilisation du site web et pour améliorer nos services, mais nous n'avons pas besoin de cookies pour de nombreuses parties de nos services, comme la recherche et la consultation de profils ou de listes d'utilisateurs publics. Un cookie est un petit fichier de données qui est transféré sur le disque dur de votre ordinateur. Rightnow By Brenco peut utiliser des cookies de session et des cookies persistants pour mieux comprendre la manière dont vous interagissez avec nos Services, pour surveiller l'utilisation globale par nos utilisateurs et l'acheminement du trafic Web sur nos Services, et pour améliorer nos Services. La plupart des navigateurs Internet acceptent automatiquement les cookies. Vous pouvez demander à votre navigateur, en modifiant ses options, de ne plus accepter les cookies ou de vous inviter à accepter un cookie provenant des sites Web que vous visitez."
            .tr()),
    SizedBox(height: 15),
    titleText("Services de tiers".tr()),
    bodyText(
        "Rightnow By Brenco utilise une variété de services hébergés par des tiers pour nous aider à fournir nos services, comme l'hébergement de nos différents blogs et wikis, et pour nous aider à comprendre l'utilisation de nos services, comme Google Analytics. Ces services peuvent recueillir des informations envoyées par votre navigateur dans le cadre d'une demande de page Web, comme des cookies ou votre demande IP."
            .tr()),
    SizedBox(height: 15),
    titleText("Base juridique du traitement".tr()),
    bodyText(
        "Nous avons le droit légal d'utiliser vos informations personnelles de la manière décrite dans la présente politique de confidentialité sur la base de votre consentement, ou de la nécessité d'utiliser les informations personnelles pour vous fournir les biens ou services que vous demandez, ou à des fins légitimes de poursuivre notre relation existante avec vous ou de prévenir la fraude. Par conséquent, vous avez une obligation contractuelle plutôt que légale de fournir ces informations. Si vous ne fournissez pas ces informations, il se peut que vous ne puissiez pas utiliser nos services et que nous ne soyons pas en mesure de vous fournir les biens ou services que vous demandez."
            .tr()),
  ];

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 80),
          child: ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return _data[index];
            },
          ),
          /*(
            children: [
              //_title("Utilisateur".tr()),
              bodyText(
                  "AXA Assurances Algérie respecte la vie privée de ses employés et s'assureque toutes les données à caractère personnel sont traitées conformémentaux meilleures pratiques en matière de confidentialité et à la législationapplicable en matière de Données à Caractère Personnel,"
                      .tr()),
              SizedBox(height: 8),
              bodyText(
                  "Dans ce contexte, on entend par Données à Caractère Personnel touteinformation concernant une personne physique identifiée ou identifiable(une personne concernée) ; une personne physique identifiable est unepersonne   qui   peut   être   identifiée,   directement   ou   indirectement,notamment par référence  à un  identifiant  tel qu'un  nom,  un numérod'identification, une donnée de localisation, un identifiant en ligne ou à unou plusieurs facteurs spécifiques de l'identité physique, physiologique,génétique, mentale, économique, culturelle."
                      .tr()),
              SizedBox(height: 8),
              bodyText(
                  "Dans le cadre de la mise à disposition d’une plateforme de services desanté et de bien-être à destination des employés AXA Algérie, Vous (entant qu’employé(e) d’AXA) êtes informé(e) et prenez connaissance du faitBRENCO ENGINEERING & CONSULTING  EURL  agit en tant que Responsable detraitement  (c’est-à-dire  qu’il   détermine  les  finalités   et   les  moyens  dutraitement   de   ses   informations).   Le   traitement   de   Vos   donnéespersonnelles par BRENCO ENGINEERING & CONSULTING  EURL  a pour finalitédevous donner un bilan de votre santé."
                      .tr()),
              SizedBox(height: 8),
              bodyText(
                  "Les données chargées sur la plateforme sont confidentielles et Vous seulpouvez   y   avoir   accès   étant   donné   que   cet   espace   personnel   Vousappartient. Elles sont conservées pendant une durée trois mois compterde votre inactivité sur la plateforme ou de la date de clôture du contratentre BRENCO ENGINEERING & CONSULTING  EURL et votre entité, sous réserveque Vous ne consentiez de façon libre, éclairée, spécifique et univoque àune conservation plus longue de ces documents."
                      .tr()),
              SizedBox(height: 8),
              bodyText(
                  "Dans le cas où Vous souhaiteriez faire valoir vos droits concernant letraitement de vos données personnelles  , il Vous appartient de Vousréférer   à   la   notice   d’information   sur   le   traitement   des   donnéespersonnelles mise à disposition par BRENCO ENGINEERING & CONSULTING  EURL."
                      .tr()),
              SizedBox(height: 8),
              bodyText(
                  "Le prestataire héberge et traite des données de santé. Il fait appel à dessous-traitants   situés   en  Algérie   qui   sont   certifiés   ISO90001,   SOPHOSPARTNER et agréé par l’ARPCE"
                      .tr()),

              SizedBox(height: 8),
              bodyText(
                  "Le prestataire héberge et traite des données de santé. Il fait appel à dessous-traitants   situés   en  Algérie   qui   sont   certifiés   ISO90001,   SOPHOSPARTNER et agréé par l’ARPCEPour   plus   d’informations   sur   les   traitements   de   données   personnellesréalisés par AXA ALGERIE veuillez consulter la Politique de protection desdonnées à caractère personnel disponible sur notre site web"
                      .tr())
            ],
          ),*/
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                        ),
                        onPressed: () {
                          //SystemNavigator.pop();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Refuser".tr(),
                          style: TextStyle(color: COLOR_PRIMARY),
                        )),
                  ),
                  SizedBox(width: 15),*/
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Retour".tr())),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
