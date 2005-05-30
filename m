From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001145]: On ALSA 1.0.9 running more than one player with different users does not work
Date: Mon, 30 May 2005 08:37:14 +0200
Message-ID: <d12369b31e9a4198f697ebe322d72d79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C6F4F18A
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 08:37:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1145> 
======================================================================
Reported By:                ipartola
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1145
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2005.0
Kernel Version:             linux-2.6.11-gentoo
======================================================================
Date Submitted:             05-30-2005 08:37 CEST
Last Modified:              05-30-2005 08:37 CEST
======================================================================
Summary:                    On ALSA 1.0.9 running more than one player with
different users does not work
Description: 
If I run mpg321 some.mp3 as john I cannot run mpg321 other.mp3 as ben.

This does not work even if one user is root either. I simply get "No
default libao driver available".
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-05 08:37 ipartola       New Issue                                    
05-30-05 08:37 ipartola       Distribution              => Gentoo 2005.0   
05-30-05 08:37 ipartola       Kernel Version            => linux-2.6.11-gentoo
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
