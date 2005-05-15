From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001110]: Some switch is missing
Date: Sun, 15 May 2005 16:37:25 +0200
Message-ID: <e907d7cd59057772e3401be160537d8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BC314329
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2005 16:37:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1110> 
======================================================================
Reported By:                technik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1110
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               mandriva , suse 9.2
Kernel Version:             2.6
======================================================================
Date Submitted:             05-14-2005 10:40 CEST
Last Modified:              05-15-2005 16:37 CEST
======================================================================
Summary:                    Some switch is missing
Description: 
When you open mixer(kmix, alsamixer or other) you can't muteing micropone,
line and other record source. It's a big problem when you using internet
telephone like skype. When you speak to mic you hear your voice an your
friend, and you can't make lauder becouse mic and speker interference.
======================================================================

----------------------------------------------------------------------
 technik - 05-15-05 16:30 
----------------------------------------------------------------------
:) J try alsa mixer and other but it's the same problem , but J start MDK
move 9.2 and its all okey, for knoppix 3.4 it's okey too, generaly old
version alsa its ok.

----------------------------------------------------------------------
 tiwai - 05-15-05 16:37 
----------------------------------------------------------------------
Did you really change "Mic Playback Volume"?
Please elaborate what you did exactly.

Also, I don't know what do you mean "ok".  There shouldn't be changes in
this regard between different versions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 10:40 technik        New Issue                                    
05-14-05 10:40 technik        Distribution              => mandriva , suse 9.2
05-14-05 10:40 technik        Kernel Version            => 2.6             
05-15-05 15:38 tiwai          Note Added: 0004660                          
05-15-05 16:07 technik        Note Added: 0004664                          
05-15-05 16:13 tiwai          Note Added: 0004665                          
05-15-05 16:30 technik        Note Added: 0004666                          
05-15-05 16:37 tiwai          Note Added: 0004667                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
