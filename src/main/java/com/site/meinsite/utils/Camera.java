package com.site.meinsite.utils;

import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.videoio.VideoCapture;

public class Camera extends JFrame{

	private static final long serialVersionUID = 5504544382921954944L;

	//카메라 화면
	private JLabel cameraScreen;
	
	private JButton btnCapture;
	
	private VideoCapture capture;
	private Mat image;
	
	private boolean clicked = false;
	
	public Camera() {
		//UI 디자인
		setLayout(null);
		
		cameraScreen = new JLabel();
		cameraScreen.setBounds(0, 0, 640, 480);
		add(cameraScreen);
		
		btnCapture = new JButton("캡처");
		btnCapture.setBounds(300, 480, 80, 40);
		add(btnCapture);
		
		btnCapture.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				clicked = true;				
			}		
		});
		
		addWindowListener(new WindowAdapter() {
			
			@Override
			public void windowClosing(WindowEvent e) {
				super.windowClosing(e);
				capture.release();
				image.release();
				System.exit(0);
			}
		});
		
		setSize(new Dimension(640, 560));
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
	}
	
	//카메라 생성
	public void  startCamera() {
		capture = new VideoCapture(0);
		image = new Mat();
		byte[] imageData;
		
		ImageIcon icon;
		while(true) {
			//이미지를 배열로 읽기
			capture.read(image);
			
			//배열을 바이트로 변환
			final MatOfByte buf = new MatOfByte();
			Imgcodecs.imencode(".jpg", image, buf);
			
			imageData = buf.toArray();
			
			//JLabel에 추가
			icon = new ImageIcon(imageData);
			cameraScreen.setIcon(icon);
			
			//캡처 후 파일에 저장
			if(clicked) {
				String name = "camCard";
				
				//파일에 쓰기 
				Imgcodecs.imwrite("/resources/namecard_img_files/" + name + ".jpg", image);
				
				clicked = false;				
			}
			
			
		}
	}
	public static void main(String[] args) {
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		EventQueue.invokeLater(new Runnable() {

			@Override
			public void run() {
				Camera camera = new Camera();
				
				//스레드에서 카메라 실행
				new Thread(new Runnable() {

					@Override
					public void run() {
						camera.startCamera();
						
					}
					
				}).start();
				
			}
			
			
		});
		
	}
}
