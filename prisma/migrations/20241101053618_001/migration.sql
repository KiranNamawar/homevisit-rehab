-- AlterTable
ALTER TABLE "User" ALTER COLUMN "image" DROP NOT NULL;

-- CreateTable
CREATE TABLE "Therapist" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Therapist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Service" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TherapistServices" (
    "id" SERIAL NOT NULL,
    "therapistId" INTEGER NOT NULL,
    "serviceId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TherapistServices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appointment" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "therapistId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "locationId" INTEGER NOT NULL,

    CONSTRAINT "Appointment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppointmentServices" (
    "id" SERIAL NOT NULL,
    "appointmentId" INTEGER NOT NULL,
    "serviceId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AppointmentServices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationProfile" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "pincode" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "LocationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ServiceToTherapist" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Therapist_email_key" ON "Therapist"("email");

-- CreateIndex
CREATE UNIQUE INDEX "TherapistServices_therapistId_serviceId_key" ON "TherapistServices"("therapistId", "serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "AppointmentServices_appointmentId_serviceId_key" ON "AppointmentServices"("appointmentId", "serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "_ServiceToTherapist_AB_unique" ON "_ServiceToTherapist"("A", "B");

-- CreateIndex
CREATE INDEX "_ServiceToTherapist_B_index" ON "_ServiceToTherapist"("B");

-- AddForeignKey
ALTER TABLE "TherapistServices" ADD CONSTRAINT "TherapistServices_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "Therapist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TherapistServices" ADD CONSTRAINT "TherapistServices_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "Therapist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "LocationProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppointmentServices" ADD CONSTRAINT "AppointmentServices_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "Appointment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppointmentServices" ADD CONSTRAINT "AppointmentServices_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationProfile" ADD CONSTRAINT "LocationProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ServiceToTherapist" ADD CONSTRAINT "_ServiceToTherapist_A_fkey" FOREIGN KEY ("A") REFERENCES "Service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ServiceToTherapist" ADD CONSTRAINT "_ServiceToTherapist_B_fkey" FOREIGN KEY ("B") REFERENCES "Therapist"("id") ON DELETE CASCADE ON UPDATE CASCADE;
