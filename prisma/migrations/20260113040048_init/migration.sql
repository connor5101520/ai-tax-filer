-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaxReturn" (
    "id" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'IN_PROGRESS',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "TaxReturn_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnInput" (
    "id" TEXT NOT NULL,
    "filingStatus" TEXT NOT NULL,
    "dependentsU17" INTEGER NOT NULL DEFAULT 0,
    "w2Wages" INTEGER NOT NULL,
    "w2Withholding" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "ssnLast4" TEXT NOT NULL,
    "address1" TEXT NOT NULL,
    "address2" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip" TEXT NOT NULL,
    "taxReturnId" TEXT NOT NULL,

    CONSTRAINT "ReturnInput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnResult" (
    "id" TEXT NOT NULL,
    "agi" INTEGER NOT NULL,
    "taxableIncome" INTEGER NOT NULL,
    "tax" INTEGER NOT NULL,
    "credits" INTEGER NOT NULL,
    "payments" INTEGER NOT NULL,
    "refund" INTEGER NOT NULL,
    "amountOwed" INTEGER NOT NULL,
    "taxReturnId" TEXT NOT NULL,

    CONSTRAINT "ReturnResult_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "TaxReturn_userId_year_key" ON "TaxReturn"("userId", "year");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnInput_taxReturnId_key" ON "ReturnInput"("taxReturnId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnResult_taxReturnId_key" ON "ReturnResult"("taxReturnId");

-- AddForeignKey
ALTER TABLE "TaxReturn" ADD CONSTRAINT "TaxReturn_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnInput" ADD CONSTRAINT "ReturnInput_taxReturnId_fkey" FOREIGN KEY ("taxReturnId") REFERENCES "TaxReturn"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReturnResult" ADD CONSTRAINT "ReturnResult_taxReturnId_fkey" FOREIGN KEY ("taxReturnId") REFERENCES "TaxReturn"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
