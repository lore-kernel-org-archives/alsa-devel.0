From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001572]: Simultaneous sound from speakers and headphone
Date: Thu, 19 Jan 2006 18:27:12 +0100
Message-ID: <ac5951d9e2d4839c788db721d380d9cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B35B173
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 18:27:13 +0100 (MET)
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


The issue 0001663 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1572> 
======================================================================
Reported By:                mjsb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1572
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.1.13-gentoo-r3
======================================================================
Date Submitted:             11-17-2005 16:31 CET
Last Modified:              01-16-2006 11:19 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone
Description: 
I cannot ear headphones without having sound from front speakers
simultaneously.
Volume of headphones is adjusted by front speakers and when muting front
speakers also mutes headphones.
(in MS Windows, inserting headphones automatically disables sound from
front speakers)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001663 LW20 bugs with headphone input, realtek...
======================================================================

----------------------------------------------------------------------
 mjsb - 12-08-05 21:23 
----------------------------------------------------------------------
Correction: kernel is 2.6.13-gentoo-r3.

----------------------------------------------------------------------
 mjsb - 01-16-06 11:19 
----------------------------------------------------------------------
Someone else has reported bug #0001663 which describes the same problem as
here (#0001572).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 16:31 mjsb           New Issue                                    
11-17-05 16:31 mjsb           Distribution              => Gentoo Linux    
11-17-05 16:31 mjsb           Kernel Version            => 2.1.13-gentoo-r3
11-17-05 16:33 mjsb           Issue Monitored: mjsb                        
12-08-05 21:23 mjsb           Note Added: 0006962                          
01-16-06 11:19 mjsb           Note Added: 0007685                          
01-19-06 18:27 rlrevell       Relationship added       has duplicate 0001663
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
