From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002064]: Line-in/mic-in not working
Date: Mon, 24 Apr 2006 16:02:54 +0200
Message-ID: <247c4a9bc5a9496edcd05fd919619bd0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6861B192
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 16:02:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2064> 
======================================================================
Reported By:                lwelyn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2064
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             04-24-2006 15:12 CEST
Last Modified:              04-24-2006 16:02 CEST
======================================================================
Summary:                    Line-in/mic-in not working
Description: 
This card is very great for laptops under linux because of its size and
hardware mixing. But i was very shocked after i realized that the input
dont work. 
Not the mic in and not the line in.
I would like to help to fix this ugly thing, if i can. Because lots of my
friends with linux on their laptop own this card too.
======================================================================

----------------------------------------------------------------------
 lwelyn - 04-24-06 15:56 
----------------------------------------------------------------------
Oh huh sorry. I thought my profile would be enough.
Its a
Sound Blaster Audigy 2 ZS Notebook PCMCIA .

----------------------------------------------------------------------
 jcdutton - 04-24-06 16:02 
----------------------------------------------------------------------
It clearly states on the alsa web site "soundcard matrix" that
"Digital/Analog input does not work yet."
So, this should not have been a surprise.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-06 15:12 lwelyn         New Issue                                    
04-24-06 15:12 lwelyn         Kernel Version            => 2.6.16.1        
04-24-06 15:50 rlrevell       Note Added: 0009456                          
04-24-06 15:56 lwelyn         Note Added: 0009459                          
04-24-06 16:02 jcdutton       Note Added: 0009463                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
