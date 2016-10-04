--1.1 Построить запрос, формирующий вывод всех данных обо всех организациях.
  SELECT * FROM `организации`

--1.2 Построить запрос, формирующий вывод  названия, УНП и фамилии руководителя
--    всех  организаций, отсортированные в алфавитном порядке по названию организации.
  SELECT `название`,`УНП`,`Руководитель` FROM `организации` ORDER BY `название` ASC

--1.3 Вывести все данные об организации с названием «ООО «Гранит»»
  SELECT * FROM `организации` WHERE `название`='ООО "Гранит"'

--1.4 Вывести все данные об организациях, являющихся ООО (Обществом с ограниченной ответственностью).
  SELECT * FROM `организации` WHERE `название` like '%ООО%'

--1.5 Сформировать список (содержащий спецификацию, отпускную цену, остаток) товаров
--    на складе по коду каталога 101, остатки которых более 100 единиц.
  SELECT * FROM `склад` WHERE `КодТовара`=101 AND `Остаток`>100

--1.6 Получить список, содержащий спецификацию и отпускную стоимость всех товаров
--    на складе по коду каталога 500 и отсортированный в обратном порядке по отпускной стоимости.
  SELECT `Спецификация`,`ЦенаОтпускная` FROM `склад` WHERE `КодТовара`=500  ORDER BY `ЦенаОтпускная` DESC

--2.1 Вывести все заказы, которые оформил сотрудник фирмы по фамилии “Ружанская О.Л.»  в феврале 2010г.,
--    с указанием кода заказа, номера накладной, даты заказа и общей суммы.
  SELECT `заказы`.`ЗаказID`, `заказы`.`НомерНакладной`, `заказы`.`ДатаЗаказа`,`заказы`.`ОбщаяСумма`
    FROM `сотрудники`
    JOIN `заказы` ON `заказы`.`СотрудникID`=`сотрудники`.`СотрудникID`
      WHERE `сотрудники`.`ФИО`='Ружанская О.Л.' AND `заказы`.`ДатаЗаказа` BETWEEN '2010-02-01' AND '2010-02-58'

--2.2 Вывести наименование, спецификацию и остатки на складе товаров с наименованием «Мониторы».
  SELECT `каталогтоваров`.`Наименование`, `склад`.`Спецификация`, `склад`.`Остаток`
    FROM `каталогтоваров`
    JOIN `склад` ON `каталогтоваров`.`КодТовара`= `склад`.`КодТовара`
      WHERE `каталогтоваров`.`Наименование`='Монитор'

--2.3 Вывести (наименование, спецификацию, дату и количество) поставки на склад мониторов,
--    отсортированные по спецификации и дате в прямом порядке.
  SELECT `каталогтоваров`.`Наименование`, `склад`.`Спецификация`, `приходсклад`.`Количество`, `приходсклад`.`ДатаПоставки`
    FROM `склад`
    JOIN `каталогтоваров` ON `каталогтоваров`.`КодТовара`= `склад`.`КодТовара`
    JOIN `приходсклад` ON `приходсклад`.`СкладID`= `склад`.`Склад`
      WHERE `каталогтоваров`.`Наименование`='Монитор' ORDER BY `склад`.`Спецификация` ASC,  `приходсклад`.`ДатаПоставки` ASC

--2.4 Вывести (наименование, спецификацию, дату поставки, количество и организацию) поставки УП «Белкантон» на склад товара с наименованием «Телевизоры».
  SELECT `организации`.`Название`,
      `каталогтоваров`.`Наименование`,
      `склад`.`Спецификация`,
      `приходсклад`.`Количество`,
      `приходсклад`.`ДатаПоставки`
    FROM `склад`
      JOIN `каталогтоваров` ON `каталогтоваров`.`КодТовара`= `склад`.`КодТовара`
      JOIN `приходсклад` ON `приходсклад`.`СкладID`= `склад`.`Склад`
      JOIN `поставщики` ON `приходсклад`.`КодПоставщика`= `поставщики`.`МенеджерПоставщикаID`
      JOIN `организации` ON `поставщики`.`ПоставщикID`=`организации`.`ОрганизацииID`
        WHERE `каталогтоваров`.`Наименование`='Телевизор' AND `организации`.`Название`='УП "Белкантон"'

--2.5 Вывести состав заказа с кодом 13.
  SELECT `заказы`.`ЗаказID`,
    `заказы`.`НомерНакладной`,
    `заказы`.`ДатаЗаказа`,
    `заказы`.`ОбщаяСумма`,
    `заказы`.`ДатаОтгрузки`,
    `заказы`.`Примечание`,
    `состояниезаказа`.`Состояние`,
    `клиенты`.`Менеджер`,
    `сотрудники`.`ФИО`
    FROM `заказы`
      JOIN `состояниезаказа` ON `состояниезаказа`.`СостояниеID`=`заказы`.`СостояниеID`
      JOIN `клиенты` ON `клиенты`.`МенеджерКлиентаID`=`заказы`.`МенеджерКлиентаID`
      JOIN `сотрудники` ON `сотрудники`.`СотрудникID`=`заказы`.`СотрудникID`
        WHERE `каталогтоваров`.`КодТовара`='13'

--2.6 Вывести отсортированный по менеджерам (прямом в порядке) список менеджеров клиентов и коды заказов, которые они сделали.
  SELECT `заказы`.`ЗаказID`,
         `клиенты`.`Менеджер`
    FROM `заказы`
      JOIN `клиенты` ON `клиенты`.`МенеджерКлиентаID`=`заказы`.`МенеджерКлиентаID`
      ORDER BY `клиенты`.`Менеджер` ASC

--2.7 Вывести отсортированный по менеджерам (прямом в порядке) список всех менеджеров клиентов и коды заказов, которые они сделали.
  SELECT `заказы`.`ЗаказID`,
         `клиенты`.`Менеджер`
    FROM `заказы`
      LEFT JOIN `клиенты` ON `клиенты`.`МенеджерКлиентаID`=`заказы`.`МенеджерКлиентаID`
      ORDER BY `клиенты`.`Менеджер` ASC

--2.8 Вывести коды и наименования товаров, которые еще не поставлялись (нет на складе)
  SELECT `каталогтоваров`.*
    FROM `каталогтоваров` LEFT JOIN `склад`
    USING (`КодТовара`)
    WHERE `склад`.`КодТовара` IS NULL;