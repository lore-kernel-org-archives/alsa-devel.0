From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001067]: sound partially working on medion laptop
Date: Tue, 19 Apr 2005 23:47:09 +0200
Message-ID: <c0dc03df8681275eb5b68beecbd7866f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 746B91DA
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 23:47:09 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1067> 
======================================================================
Reported By:                fab31
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1067
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu 5.04
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-19-2005 23:47 CEST
Last Modified:              04-19-2005 23:47 CEST
======================================================================
Summary:                    sound partially working on medion laptop
Description: 
I have a medion laptop with an hda intel card, I have 3 outputs for 5.1    
                                                
(works well), one output for spdif (not tested), two inputs (not          
                                                 
tested) AND one output for headphones (no sound) and 2 internal speakers  
                                                 
+ 1 bass stuff (no sound).                                                
                                                 
                                                                          
                                                 
I don't even have console beep on the two last...                         
                                                 
I can do sniffing, try reverse-engenering etc... I kept XP for now so I   
                                                 
may sniff something ? I need someone to point me the way, I can't stand   
                                                 
having no sound on those speakers...                                      
                                                 
                                                                          
                                                 In fact, I never got 5.1
cards so I can't say but when I play some
sound, only the "Front"  and "Surround" are outputing a sound, Center
don't do nothing too... The sound seems to have been "bass cut", I can
ear only Trebbles...

Here is a screenshot of my mixer:
http://fab.gnux.info/mixer/mixer.png

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-05 23:47 fab31          New Issue                                    
04-19-05 23:47 fab31          Distribution              => ubuntu 5.04     
04-19-05 23:47 fab31          Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
