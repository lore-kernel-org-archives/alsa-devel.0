From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001113]: application crash
Date: Sat, 28 May 2005 12:33:09 +0200
Message-ID: <4e506a7f19ef55344e701cb718e001f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7351F214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:33:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1113> 
======================================================================
Reported By:                Yota_VGA
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1113
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.8-gentoo-r9
======================================================================
Date Submitted:             05-16-2005 19:52 CEST
Last Modified:              05-28-2005 12:33 CEST
======================================================================
Summary:                    application crash
Description: 
Some applications crash when i listen a wave with aplay (and in some other
circostances, i've not be tested very well), like as xmms (when I use the
alsa plugin and I play a song) and alsamixer.
======================================================================

----------------------------------------------------------------------
 Stephan Wurm - 05-27-05 12:13 
----------------------------------------------------------------------
Forgot to say, that I haven't tried Alsa 1.0.9rc* yet.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:33 
----------------------------------------------------------------------
This is most likely a bug in xmms.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-16-05 19:52 Yota_VGA       New Issue                                    
05-16-05 19:52 Yota_VGA       Distribution              => gentoo          
05-16-05 19:52 Yota_VGA       Kernel Version            => 2.6.8-gentoo-r9 
05-27-05 12:12 Stephan Wurm   Note Added: 0004745                          
05-27-05 12:13 Stephan Wurm   Issue Monitored: Stephan Wurm                    
05-27-05 12:13 Stephan Wurm   Note Added: 0004746                          
05-28-05 12:33 jcdutton       Note Added: 0004773                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
