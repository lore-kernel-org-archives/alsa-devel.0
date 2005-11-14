From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001026]: The "Gamesurround" Fortissimo III _Not_ The Fortissimo III.
Date: Mon, 14 Nov 2005 10:37:03 +0100
Message-ID: <31b55473eff24b054f973f889626263c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1FFC619E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:37:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1026> 
======================================================================
Reported By:                tony
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1026
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             03-31-2005 06:42 CEST
Last Modified:              11-14-2005 10:37 CET
======================================================================
Summary:                    The "Gamesurround" Fortissimo III _Not_ The
Fortissimo III.
Description: 
Hi, 
   Over Two Years Ago I Bought A Hercules (Guillimot) Gamesurround
Fortissimo III
PCI Sound Card. It Was Like A Limited Edition Thing, I Don't Think Alot
Were Produced Or Sold, Anyway I Have Four Linux Installations Running On
The Same Computer With Two Of XP. Ubuntu, Slackware, Mandrake And SuSE,
They Are All No More Than One Year Old Distributions, Possibly Newer. All
Use The alsa For Sound.
Here's What Happens The Sound Functions Fine However After Less Than Sixty
Seconds The Sound Cuts Out And Feed Back Is Produced. I Mean Really Loud
Buzzing! ! This Cannot Be Healthy For The Card. All Of The Installed
Systems Apart From XP. Do This.
alsa recognises the sound chip as cs46xx. It is a Crystal Sound Fusion
Chip But a Unique Config? I Know This Card Not To Be The Same As 
The Similar Fortissimo II Or Fortissimo III But It Does Output 7.1
Surround.

Any Info Needed I Can Get And Can Also Test Anything To Try And Get A
Realistic Sound Throughput.

MayBe A Seperate Driver for This Unique Card Is In Order?

If So, contact Me By E-mail If I Can Assist?
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 10:37 
----------------------------------------------------------------------
Upgrade your distro and kernels. 2.6.8 is really old kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-05 06:42 tony           New Issue                                    
03-31-05 06:42 tony           Distribution              => SuSE Linux 9.2  
03-31-05 06:42 tony           Kernel Version            => 2.6.8           
11-14-05 10:37 perex          Status                   new => resolved     
11-14-05 10:37 perex          Resolution               open => suspended   
11-14-05 10:37 perex          Assigned To               => perex           
11-14-05 10:37 perex          Note Added: 0006708                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
