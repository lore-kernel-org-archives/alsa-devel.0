From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000967]: sound dissapears
Date: Fri, 18 Mar 2005 15:44:38 +0100
Message-ID: <73a34a439cb30d4516fe450e972e6d2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 48EE3244
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 15:44:38 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=967> 
======================================================================
Reported By:                paulius
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   967
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10, 2.6.11
======================================================================
Date Submitted:             03-07-2005 00:56 CET
Last Modified:              03-18-2005 15:44 CET
======================================================================
Summary:                    sound dissapears
Description: 
While using gstreamer based apps, like totem, rhythmbox for a few hours
sound dissapears and I am not able to use other programs, because they
also doesnt make sound. The only way for sound to work is to _completely_
shutdown a PC, even reboot doesnt work. Any ideas what could be wrong? As
I understand it is kernel related problem. 
======================================================================

----------------------------------------------------------------------
 tiwai - 03-09-05 18:52 
----------------------------------------------------------------------
Did you see any suspicious kernel messages?

----------------------------------------------------------------------
 paulius - 03-18-05 15:44 
----------------------------------------------------------------------
Checked log files and dmesg, and seems there are no messages at the moment
when sound disaprears.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-05 00:56 paulius        New Issue                                    
03-07-05 00:56 paulius        Distribution              => Gentoo          
03-07-05 00:56 paulius        Kernel Version            => 2.6.10, 2.6.11  
03-09-05 18:52 tiwai          Note Added: 0003839                          
03-18-05 15:44 paulius        Note Added: 0003995                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
