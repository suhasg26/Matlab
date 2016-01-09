% SGR_VCO_OTA_TRAN_SUMMARY.m
% Suhas G Rao
% 9th Jan 2016
% Purpose: Generating PDF from transient curves for VCO_OTA
% Summary of plots


tic;  % Start clock to find execution time
clc; clear;


final_folder_Dir = '/home/user2/suhas/cadence/tsmc55/RESULTS_OCN/VCO_OTA/TRAN';
final_folder_Dir_VCO = '/home/user2/suhas/cadence/tsmc55/RESULTS_OCN/VCO_OTA/TRAN/UGB/';
final_folder_Dir_GM = '/home/user2/suhas/cadence/tsmc55/RESULTS_OCN/GM_OTA/TRAN/UGB/';

line_width = 1.0; % Linewidth for graphs
font_size_axis =10; % Fontsize for graph axis
font_size_supertitle = font_size_axis+2;
font_size_datatip = font_size_axis-1; % Fontsize for datatip
supertitle_x_offset = -0.0; % x offset for supertitle for each graph
supertitle_y_offset = 0.04; 

b=[5 20 50 200];

for j=1:1:uint8(length(b))


a=[30 45 60 70];

clf;

	save_pdf_stb = fullfile(final_folder_Dir,sprintf('%dM',b(j)));	
	delete(strcat(save_pdf_stb, '.pdf'))

for i=1:1:length(a)

warning('off', 'all'); % Turn off all the warnings temporarily (remember to switch them back on at the end)

	M=dlmread(strcat(final_folder_Dir_VCO,sprintf('%dM/',b(j)),sprintf('PM_%d',a(i)),'/tran.txt'),' ',0,0);
	t1=M(:,1); % time
	t2=M(:,2); % vip
	t3=M(:,3); % vin
	t4=M(:,4); % outp
	t5=M(:,5); % outn

	s1=subplot(2,2,i); hold on; box on;       
	f1=plot(t1,t2,t1,t3,t1,t4,t1,t5,'LineWidth',line_width); grid on; fig_set_text(strcat('@ PM = ',sprintf('%d',a(i))),'time (s)','Amplituede (V)',font_size_axis);
	
	f2=plot(t1,t2,t1,t3,t1,t4,t1,t5,'LineWidth',line_width); grid on; fig_set_text(strcat('Zoomed @ PM = ',sprintf('%d',a(i))),'time (s)','Amplituede (V)',font_size_axis)
	xlim([25e-9,0.8e-7]);
 	

end

mtit(sprintf('UGB = %dM',b(j)), 'fontsize', font_size_supertitle, 'xoff', supertitle_x_offset, 'yoff', supertitle_y_offset,'FontName','Times','fontweight','bold');
makedatatip(f2(2),[find(t1==51e-9);find(t1==60e-9)]);
export_fig(save_pdf_stb,'-pdf','-append','-nocrop');

end
    
warning('on', 'all'); % Turn all the warnings on again
toc;  % Stop clock to find execution time
