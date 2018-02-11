package org.usfirst.frc.team5212.robot;

import com.ctre.phoenix.motorcontrol.can.WPI_TalonSRX;
import edu.wpi.first.networktables.NetworkTable;
import edu.wpi.first.networktables.NetworkTableEntry;
import edu.wpi.first.networktables.NetworkTableInstance;
import edu.wpi.first.wpilibj.*;
import edu.wpi.first.wpilibj.drive.*;
import edu.wpi.first.wpilibj.command.*;

public class Robot extends IterativeRobot {

	/* talons for arcade drive */
	WPI_TalonSRX frontLeftMotor = new WPI_TalonSRX(2);
	WPI_TalonSRX frontRightMotor = new WPI_TalonSRX(0);

	/* extra talons and victors for six motor drives */
	
	//WPI_TalonSRX leftSlave = new WPI_TalonSRX(3);
	//WPI_TalonSRX rightSlave = new WPI_TalonSRX(1);
	
	//WPI_TalonSRX leftSecondSlave = new WPI_TalonSRX();
	//WPI_TalonSRX rightSecondSlave = new WPI_TalonSRX();

	DifferentialDrive drive = new DifferentialDrive(frontLeftMotor, frontRightMotor);

	Joystick joy = new Joystick(0);
	
	
	NetworkTable table;
	NetworkTableInstance inst;

	NetworkTableEntry leftRawData;
	NetworkTableEntry rightRawData;
	
	final int DEFAULT_DRIVE = 0;

	/**
	 * This function is run when the robot is first started up and should be
	 * used for any initialization code.
	 */
	public void robotInit() {
		/*
		 * take our extra talons and just have them follow the Talons updated in
		 * arcadeDrive
		 */
		//leftSlave.follow(frontLeftMotor);
		//rightSlave.follow(frontRightMotor);
		
		

		/* drive robot forward and make sure all 
		 * motors spin the correct way.
		 * Toggle booleans accordingly.... */
		frontLeftMotor.setInverted(false);
		//leftSlave.setInverted(false);
		
		frontRightMotor.setInverted(false);
		//rightSlave.setInverted(false);
		
		table = inst.getTable("test");

		System.out.println(table.getEntry("test"));
		
		//leftRawData = table.getEntry("left");
		//rightRawData = table.getEntry("right");
	}
	
	public void autonomousInit() {
		
	}
	
	public void autonomousPeriodic() {
		
	}

	/**
	 * This function is called periodically during operator control
	 */
	public void teleopPeriodic() {
//		/* sign this so forward is positive */
//		double forward = -1.0 * _joy0.getY();
//		/* sign this so right is positive. */
//		double turn = +1.0 * _joy0.getY();
//		/* deadband */
//		if (Math.abs(forward) < 0.10) {
//			/* within 10% joystick, make it zero */
//			forward = 0;
//		}
//		if (Math.abs(turn) < 0.10) {
//			/* within 10% joystick, make it zero */
//			turn = 0;
//		}
		/* print the joystick values to sign them, comment
		 * out this line after checking the joystick directions. */
//		System.out.println("JoyY:" + forward + "  turn:" + turn );
		/* drive the robot, when driving forward one side will be red.  
		 * This is because DifferentialDrive assumes 
		 * one side must be negative */
		
		System.out.println("Joy0Y:" + joy.getRawAxis(1) + "Joy1Y:" + joy.getRawAxis(3));
		
		drive.tankDrive(-1 * joy.getRawAxis(1), -1 * joy.getRawAxis(3));
		
		//float leftVal = leftRawData.getNumber(DEFAULT_DRIVE).floatValue();
		//float rightVal = rightRawData.getNumber(DEFAULT_DRIVE).floatValue();
	}
}