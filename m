From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Mon, 3 Jan 2005 00:36:06 +0100
Message-ID: <8ab18bf4f539baf15a5bf606d2e1f3b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4CA4A295
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 00:36:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              01-03-2005 00:36 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-28-04 21:13 
----------------------------------------------------------------------
You really need to file a Fedora bug report, as you have confirmed this to
be an FC3 specific problem.

https://bugzilla.redhat.com/bugzilla/index.cgi

Please provide a link to this bug report when you do so.  And, supply the
Fedora bug ID here, so we can track it.

----------------------------------------------------------------------
 misnagid - 01-03-05 00:36 
----------------------------------------------------------------------
Dear Peter,
As you requested, I have submitted a bug notification to the web site you
referred me to at Red Hat Fedora Bugzilla.
Bug 143971 has been added to the database

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
12-26-04 18:17 misnagid       Note Added: 0002942                          
12-26-04 18:38 misnagid       Note Added: 0002943                          
12-26-04 19:27 pzad           Note Added: 0002944                          
12-26-04 19:44 misnagid       File Added: test.state                       
12-26-04 19:44 misnagid       Note Added: 0002945                          
12-26-04 20:02 misnagid       Note Added: 0002946                          
12-26-04 20:09 misnagid       Note Added: 0002947                          
12-26-04 20:22 pzad           File Added: newtest.state                    
12-26-04 20:27 pzad           Note Added: 0002948                          
12-26-04 20:32 pzad           Note Added: 0002949                          
12-26-04 20:59 misnagid       Note Added: 0002950                          
12-26-04 21:11 misnagid       Note Added: 0002951                          
12-26-04 21:19 pzad           Note Added: 0002952                          
12-26-04 21:22 pzad           Note Added: 0002953                          
12-26-04 21:43 misnagid       Note Added: 0002954                          
12-26-04 21:47 pzad           Note Added: 0002955                          
12-26-04 22:18 misnagid       Note Added: 0002956                          
12-26-04 23:46 misnagid       Note Added: 0002957                          
12-27-04 10:46 pzad           Note Added: 0002958                          
12-27-04 16:33 misnagid       Note Added: 0002964                          
12-27-04 16:34 misnagid       File Added: test2.state                      
12-27-04 16:38 misnagid       Note Added: 0002965                          
12-27-04 16:45 pzad           Note Added: 0002966                          
12-27-04 16:58 misnagid       Note Added: 0002967                          
12-27-04 16:58 misnagid       File Added: test3.state                      
12-27-04 17:42 misnagid       Note Added: 0002968                          
12-27-04 17:57 misnagid       Note Added: 0002969                          
12-27-04 18:16 pzad           Note Added: 0002970                          
12-27-04 18:43 misnagid       Note Added: 0002971                          
12-27-04 19:27 misnagid       Note Added: 0002972                          
12-27-04 21:09 misnagid       Note Added: 0002975                          
12-27-04 21:31 pzad           Note Added: 0002976                          
12-27-04 21:47 misnagid       Note Added: 0002977                          
12-27-04 21:49 misnagid       Note Added: 0002978                          
12-27-04 22:00 pzad           Note Added: 0002979                          
12-27-04 22:29 misnagid       Note Added: 0002980                          
12-27-04 22:54 pzad           Note Added: 0002981                          
12-27-04 23:15 misnagid       Note Added: 0002982                          
12-27-04 23:19 misnagid       Note Added: 0002983                          
12-27-04 23:46 pzad           Note Added: 0002984                          
12-27-04 23:48 misnagid       Note Added: 0002985                          
12-28-04 21:13 rlrevell       Note Added: 0002987                          
01-03-05 00:36 misnagid       Note Added: 0003049                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
