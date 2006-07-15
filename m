From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002118]: no sound,
	just craking in headphones
Date: Sat, 15 Jul 2006 02:03:26 +0200
Message-ID: <c35da2f5b8e79c33021d1ea554217774@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3163821E
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 02:03:26 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2118> 
======================================================================
Reported By:                jobo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2118
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               FC%
Kernel Version:             2.6.16-1.2111_FC5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-13-2006 00:24 CEST
Last Modified:              07-15-2006 02:03 CEST
======================================================================
Summary:                    no sound, just craking in headphones
Description: 
hey guys i have a asus a6km laptop,  i cannot get any sound out of it, i
tried installing the new alsa driver and utils and lib, but how can i tell
which version i have installed, it has a sis chipset, please help me get
sound on this so i can never go back to windows,   thanks alot guys


Joe
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-18-06 00:34 
----------------------------------------------------------------------
Yes, the bug is fixed in the latest development tree but not in any
released version.  You can wait for the next release, or check the list
archive - an "Alsa HG howto" was posted recently.

----------------------------------------------------------------------
 jobo - 05-18-06 02:59 
----------------------------------------------------------------------
awesome so the next release will fix the no sound?   thats great, i really
appreciate your help, does anyone know when the next release will come
out? 

thanks guys

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 00:24 jobo           New Issue                                    
05-13-06 00:24 jobo           Distribution              => FC%             
05-13-06 00:24 jobo           Kernel Version            => 2.6.16-1.2111_FC5
05-17-06 16:56 jobo           Note Added: 0009851                          
05-17-06 17:27 tiwai          Status                   new => resolved     
05-17-06 17:27 tiwai          Resolution               open => fixed       
05-17-06 17:27 tiwai          Assigned To               => tiwai           
05-17-06 17:27 tiwai          Note Added: 0009854                          
05-17-06 23:31 jobo           Status                   resolved => feedback
05-17-06 23:31 jobo           Resolution               fixed => reopened   
05-17-06 23:31 jobo           Note Added: 0009859                          
05-18-06 00:34 rlrevell       Note Added: 0009860                          
05-18-06 02:59 jobo           Note Added: 0009861                          
07-15-06 02:03 Adrian Bunk    Status                   feedback => resolved
07-15-06 02:03 Adrian Bunk    Resolution               reopened => fixed   
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
