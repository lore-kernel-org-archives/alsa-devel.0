From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000907]: The sound is choppy and sometimes played at wrong speed
Date: Thu, 14 Apr 2005 13:25:40 +0200
Message-ID: <ccff1a9f90d3238d1ef1850aa672ff8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 89ECF221
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2005 13:25:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=907> 
======================================================================
Reported By:                sHINOBI
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   907
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.766_FC3
======================================================================
Date Submitted:             02-13-2005 11:36 CET
Last Modified:              04-14-2005 13:25 CEST
======================================================================
Summary:                    The sound is choppy and sometimes played at wrong
speed
Description: 
The soundcard is working, although the sound is choppy when playing sound
at 44100 Hz. 48000 Hz audio like the one at DVD's is played correctly.
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-14-05 12:51 
----------------------------------------------------------------------
The latest alsa-driver cvs has some improvements. Please try it and report.

----------------------------------------------------------------------
 Cimmo - 04-14-05 13:25 
----------------------------------------------------------------------
2 questions:

1) Have you finally received some documentation from Creative?
2) How to compile only CA0106 module?

Thanx

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-05 11:36 sHINOBI        New Issue                                    
02-13-05 11:36 sHINOBI        Distribution              => Fedora Core 3   
02-13-05 11:36 sHINOBI        Kernel Version            => 2.6.10-1.766_FC3
02-13-05 11:38 sHINOBI        Note Added: 0003583                          
03-02-05 13:22 Juha           Note Added: 0003770                          
03-19-05 18:24 jcdutton       Note Added: 0004064                          
03-22-05 22:14 tiwai          Note Added: 0004138                          
03-22-05 22:56 sHINOBI        Note Added: 0004144                          
03-23-05 12:56 tiwai          Note Added: 0004155                          
03-23-05 19:40 sHINOBI        Note Added: 0004185                          
03-27-05 01:13 sHINOBI        Note Added: 0004219                          
03-27-05 16:08 Cimmo          Note Added: 0004222                          
03-27-05 16:09 Cimmo          File Added: .asoundrc                        
03-28-05 01:31 Alinoe         Issue Monitored: Alinoe                      
03-28-05 14:09 Alinoe         Note Added: 0004240                          
04-14-05 12:51 jcdutton       Note Added: 0004490                          
04-14-05 12:51 jcdutton       Status                   assigned => feedback
04-14-05 13:25 Cimmo          Note Added: 0004492                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
