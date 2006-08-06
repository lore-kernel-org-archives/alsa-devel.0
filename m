From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002319]: can't build alsa-utils
Date: Sun, 6 Aug 2006 23:24:31 +0200
Message-ID: <cabc90fec1628915c18338e3274acda5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4907197
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 23:24:31 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2319> 
======================================================================
Reported By:                alien999999999
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2319
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               mandriva 2006
Kernel Version:             doesn't matter
======================================================================
Date Submitted:             07-30-2006 23:53 CEST
Last Modified:              08-06-2006 23:24 CEST
======================================================================
Summary:                    can't build alsa-utils
Description: 
./configure
make

ERROR! t-ja.gmo not found

(when copying the ja.gmo to alsaconf/po/t-ja.po )

ERROR! t-ru.gmo not found

copying the alsaconf/po/t-ja.gmo to alsaconf/po/t-ru.gmo .

then you can build
======================================================================

----------------------------------------------------------------------
 johncc - 08-06-06 23:24 
----------------------------------------------------------------------
Sorry to but in... Had a similar problem. Did you first install the
1.0.11 libs?

John

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-06 23:53 alien999999999 New Issue                                    
07-30-06 23:53 alien999999999 Distribution              => mandriva 2006   
07-30-06 23:53 alien999999999 Kernel Version            => doesn't matter  
08-06-06 23:24 johncc         Note Added: 0011474                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
