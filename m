From: noreply@alsa-project.org
Subject: [ALSA - driver 0000395]: No Sound-Output on FSC D1219 Mainboard (OSS-Free from Kenrel works)
Date: Sat, 17 Jul 2004 11:32:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040717093218.A6AE640009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 05EA6170
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2004 11:32:18 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id B6C03130EA
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2004 11:32:18 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000395
======================================================================
Reported By:                thorstenl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     395
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             07-17-2004 11:32 CEST
Last Modified:              07-17-2004 11:32 CEST
======================================================================
Summary:                    No Sound-Output on FSC D1219 Mainboard (OSS-Free from Kenrel works)
Description: 
On my Fujitsu Siemens D1219 Mainboard the snd-intel8x0 from alsa 1.05a
(compiled by myself) or the version that comes with the Fedora Core 2
Kernel (2.6.6-1.435.2.3; alsa 1.04a) are not able to output any sound.
Trying to experiment with the different volume settings in alsamixer did
not help. With the oss-free module i810_audio (compiled from the Fedora
Core 2 kernel-sourcecode) it works fine.  
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-17-04 11:32 thorstenl      New Bug                                      
07-17-04 11:32 thorstenl      File Added: fsc_d1219                        
07-17-04 11:32 thorstenl      Distribution              => Fedora Core 2   
07-17-04 11:32 thorstenl      Kernel Version            => 2.6.6-1.435.2.3 
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
