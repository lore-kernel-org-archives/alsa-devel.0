From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000648]: aplay -Dspdif produces choppy (beating?) audio from DTS .wav files
Date: Thu, 18 Nov 2004 17:37:32 +0100
Message-ID: <b671d28ac340b9d178581c7e5e3d39a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4D3D236
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 17:37:32 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=648> 
======================================================================
Reported By:                duanev
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   648
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake 10.1
Kernel Version:             Preemptable 2.6.8 kernel
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-14-2004 04:24 CET
Last Modified:              11-18-2004 17:37 CET
======================================================================
Summary:                    aplay -Dspdif produces choppy (beating?) audio from
DTS .wav files
Description: 
Sound produced by aplay is not smooth - audio is "chopped up" or appears to
"beat" at about 5Hz.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-17-04 18:21 
----------------------------------------------------------------------
Hmm good question.  Takashi-san. can we close this, marking it as a
duplicate of bug 646?

----------------------------------------------------------------------
 tiwai - 11-18-04 17:37 
----------------------------------------------------------------------
Closed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 04:24 duanev         New Issue                                    
11-14-04 04:24 duanev         Distribution              => Mandrake 10.1   
11-14-04 04:24 duanev         Kernel Version            => Preemptable 2.6.8
kernel
11-14-04 04:41 rlrevell       Note Added: 0002406                          
11-14-04 10:02 pzad           Note Added: 0002407                          
11-17-04 07:02 duanev         Note Added: 0002433                          
11-17-04 18:21 rlrevell       Note Added: 0002437                          
11-18-04 17:37 tiwai          Status                   assigned => resolved
11-18-04 17:37 tiwai          Resolution               open => fixed       
11-18-04 17:37 tiwai          Note Added: 0002449                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
