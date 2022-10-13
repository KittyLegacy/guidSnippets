/* pseudo code */
ALTER TABLE "PromotionCode" ADD COLUMN "USERGUID" uuid[];
- SETUP anything else required
    1. Take Integer array values tbl.PromotionCode.userIDs
    2. For Each Integer Value in tbl.PromotionCode.userIDs array
        1. Find their matching UUID (tbl.User.Id)
            1. WHERE tbl.PromotionCode.userIDs = tbl.Users.Index
            2. Take the value of tbl.Users.Id
        2. Add these UUID (tbl.User.Id) into the newly created UUID Array (tbl.PromotionCode.UUIDArray)
    3. End loop



ALTER TABLE "PromotionCode" ADD COLUMN "USERGUID" uuid;
UPDATE public."PromotionCode"
   SET "USERGUID" = (SELECT "Id"
                        FROM public."Users"
                        WHERE public."Users"."Index" = public."PromotionCode"."userIDs");
ALTER TABLE "PromotionCode" ALTER COLUMN "USERGUID" SET NOT NULL;


EXISTING ARRAY 
LOOP THROUGH ITEMS IN EXISTING ARRAY (x NUMBER OF TIMES)
    WHERE public."Users"."Index" = public."PromotionCode"."userIDs" /* conditional = if-else */
        ADD TO NEW ARRAY
END LOOP

/* IMPORT ALL DEPENDENCY AND LIBRARIES*/
/* DECLARE ALL VARIABLES HERE */
DECLARE @userIDs UUID[];
DECLARE @USERGUID UUID[];
DECLARE @cnt INT = 0;
DECLARE @cnt_total = ** ; /* they use array tables */
EXISTING ARRAY 

WHILE @cnt < cnt_total
BEGIN

    /* DO STUFF HERE */
    IF public."Users"."Index" = public."PromotionCode"."userIDs"; 
    BEGIN
        ADD TO NEW ARRAY
    END
    /* END DOING STUFF */

   SET @cnt = @cnt + 1;
END;

/* DECLARE ALL VARIABLES HERE */
 int[] oldArray = {3,4,5,7,9};
 guid[] newArray;
 int i = 0;
/* DO STUFF => ASSIGN VARIABLES, WRITE LOOPS, WRITE IF-ELSE, ASSIGN MORE VARIABLES */
while(i < oldArray.Count) {
    if(usersTable[i][0] = item) {
        newArray[i] = usersTable[i][1];
    } i++;
}

ASSUMED NEW COLUMN CREATED in PromotionCode


/* DECLARE ALL VAR */
var PromotionCode = dbcontext.PromotionCode.Load();
var Users = dbcontext.Users.Load();

/* DO STUFF */
foreach (row in PromotionCode) {
    foreach (userId in PromotionCode.UserIds[row]) {
        if(userId = User.Index) {
            PromotionCode.USERGUID[row].add(User.Id);
        }
    } dbcontext.Savechanges();
}


foreach (userid in PromotionCode.userids)
{
    var matchingid = users.index(i=> i.index == PromotionCode.userIDs); /* lambda expression */
    PromotionCode.add(new PromotionCode.userids)
}

/* Now we need to convert all these (logic) above into the Language you are writing in (SQL).*/

/* Code starts here */

ALTER TABLE "PromotionCode" ADD COLUMN IF NOT EXISTS "USERGUID" uuid[];

DO $$
DECLARE cnt INT = 1;
DECLARE cnt_total INT = 1+(SELECT COUNT(*) FROM "PromotionCode");

BEGIN
	WHILE cnt < cnt_total LOOP
		UPDATE public."PromotionCode"
			SET "USERGUID" = (
				SELECT ARRAY(
					SELECT "Id" FROM (
						SELECT "Id","Index", (SELECT "userIDs" FROM "PromotionCode" WHERE "Id" = cnt)
						FROM "Users" ORDER BY "Index" ASC
					) AS SHELL
				WHERE "Index" = ANY("userIDs"))
		   ) WHERE "Id" = cnt;
	cnt = cnt+1;
	END LOOP;
END$$;