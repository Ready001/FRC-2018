import cv2
import sys
import pyrealsense as pyrs
 
(major_ver, minor_ver, subminor_ver) = (cv2.__version__).split('.')
 
with pyrs.Service() as serv:
    with serv.Device() as dev:
 
        # Set up tracker.
        # Instead of MIL, you can also use the other items in this list
        # (GOTURN currently runs into an error)
        tracker_types = ['BOOSTING', 'MIL','KCF', 'TLD', 'MEDIANFLOW', 'GOTURN']
        tracker_type = tracker_types[2]
     
        if int(minor_ver) < 3:
            tracker = cv2.Tracker_create(tracker_type)   
        else:
            if tracker_type == 'BOOSTING':
                tracker = cv2.TrackerBoosting_create()
            if tracker_type == 'MIL':
                tracker = cv2.TrackerMIL_create()
            if tracker_type == 'KCF':
                tracker = cv2.TrackerKCF_create()
            if tracker_type == 'TLD':
                tracker = cv2.TrackerTLD_create()
            if tracker_type == 'MEDIANFLOW':
                tracker = cv2.TrackerMedianFlow_create()
            if tracker_type == 'GOTURN':
                tracker = cv2.TrackerGOTURN_create()
     
        # Read first frames and configure camera
        dev.apply_ivcam_preset(0)
        dev.wait_for_frames()
        
        for i in range(7):
            dev.wait_for_frames()
            frame = dev.color

        frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
     
        # Define an initial bounding box
        bbox = (287, 23, 86, 320)
 
        # Uncomment the line below to select a different bounding box
        bbox = cv2.selectROI(frame, False)
 
        # Initialize tracker with first frame and bounding box
        ok = tracker.init(frame, bbox)
    
     
        while True:
    
            # Read a new frame
            dev.wait_for_frames()
            frame = dev.color
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
         
            # Start timer
            timer = cv2.getTickCount()
 
            # Update tracker
            ok, bbox = tracker.update(frame)
 
            # Calculate Frames per second (FPS)
            fps = cv2.getTickFrequency() / (cv2.getTickCount() - timer);
 
            # Draw bounding box
            if ok:
                # Tracking success
                p1 = (int(bbox[0]), int(bbox[1]))
                p2 = (int(bbox[0] + bbox[2]), int(bbox[1] + bbox[3]))
                cv2.rectangle(frame, p1, p2, (255,0,0), 2, 1)
            else :
                # Tracking failure
                cv2.putText(frame, "Tracking failure detected", (100,80), cv2.FONT_HERSHEY_SIMPLEX, 0.75,(0,0,255),2)
 
            # Display tracker type on frame
            cv2.putText(frame, tracker_type + " Tracker", (100,20), cv2.FONT_HERSHEY_SIMPLEX, 0.75, (50,170,50),2);
     
            # Display FPS on frame
            cv2.putText(frame, "FPS : " + str(int(fps)), (100,50), cv2.FONT_HERSHEY_SIMPLEX, 0.75, (50,170,50), 2);
 
            # Display result
            cv2.imshow("Tracking", frame)
 
            # Exit if ESC pressed
            k = cv2.waitKey(1) & 0xff
            if k == 27 : break
