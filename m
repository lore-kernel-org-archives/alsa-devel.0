From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002275]: Speakers don't mute,
	no headphone sound with nforce MCP51
Date: Tue, 11 Jul 2006 23:41:03 +0200
Message-ID: <ed77b268cdd98221eac59c1d3502b0be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16905192
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 23:41:04 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2275> 
======================================================================
Reported By:                tekhedd
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2275
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17-gentoo-r2 #13 SMP Mon Jul 10 19:41:49 MDT
2006 x86_64 AMD Turion(tm) 64 X2  AuthenticAMD
======================================================================
Date Submitted:             07-11-2006 23:41 CEST
Last Modified:              07-11-2006 23:41 CEST
======================================================================
Summary:                    Speakers don't mute, no headphone sound with nforce
MCP51
Description: 
I am using a non-kernel 1.0.12rc1 build. The card is recognized using
default options, and has both an output level and PCM level fader. When
inserting the headphones, the speakers do not mute, and the headphones
produce no sound.

Possibly related to bug 2251. Possibly not. I'm don't even know what this
chip really is. Rebranding should be illegal.

Otherwise it works very nicely (if you accept the sound of the built in
speakers as "nice" :-)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-06 23:41 tekhedd        New Issue                                    
07-11-06 23:41 tekhedd        Distribution              => Gentoo          
07-11-06 23:41 tekhedd        Kernel Version            => 2.6.17-gentoo-r2 #13
SMP Mon Jul 10 19:41:49 MDT 2006 x86_64 AMD Turion(tm) 64 X2  AuthenticAMD
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
