From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000283]: modprobe: Can't locate module snd-via82xx
Date: Tue, 9 Nov 2004 16:18:35 +0100
Message-ID: <b02e86cf43b03baef7446633870a18b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 426BF244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:18:35 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=283> 
======================================================================
Reported By:                alihamed
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   283
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               RedHat
Kernel Version:             2.4.18-3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-19-2004 20:04 CEST
Last Modified:              11-09-2004 16:18 CET
======================================================================
Summary:                    modprobe: Can't locate module snd-via82xx
Description: 
Hi;
Firstly Thanks for your services.
and i hope u support me in this problem.
I'm using RedHat 7.3 and My Card is VIA8233 as in Hardware Browser. I
followed steps in 

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=VIA&card=&chip=via8233a&module=via82xx


but stop in this step:-
"modprobe snd-via82xx;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe
snd-seq-oss" 
because this error issue :-
 "modprobe: Can't locate module snd-via82xx
  modprobe: Can't locate module snd-pcm-oss
  modprobe: Can't locate module snd-mixer-oss
  modprobe: Can't locate module snd-seq-oss" 
Although My Path is ../alsa-utlis-1.0.4. addition I attempted replace xx
by 33 by no way.

Best Regards
Ali Hamed
======================================================================

----------------------------------------------------------------------
 perex - 09-07-04 16:47 
----------------------------------------------------------------------
Sorry, here is not a place to answer basic installation questions. Use some
ALSA forum or alsa-user mailing list. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-04 20:04 alihamed       New Issue                                    
05-19-04 20:04 alihamed       Distribution              => RedHat          
05-19-04 20:04 alihamed       Kernel Version            => 2.4.18-3        
09-07-04 16:47 perex          Status                   assigned => resolved
09-07-04 16:47 perex          Resolution               open => fixed       
09-07-04 16:47 perex          Note Added: 0001717                          
11-09-04 16:18 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
