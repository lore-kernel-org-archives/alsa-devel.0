From: Oliver Schrempf <s_schrem@ira.uka.de>
Subject: Driver Development under SuSE 8.0
Date: Wed, 5 Jun 2002 10:47:13 +0200 (MET DST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.SOL.4.33.0206051038470.25929-100000@studsun1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iraun2.uka.de (iraun2.uka.de [129.13.10.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA23687
	for <alsa-devel@alsa-project.org>; Wed, 5 Jun 2002 10:47:23 +0200
Received: from irams1.ira.uka.de ([129.13.10.5])
	by iraun2.uka.de with esmtp (Exim 3.30 #7 (Debian))
	id 17FWRn-0004pX-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2002 10:47:15 +0200
Received: from studsun1.atis-stud.uni-karlsruhe.de
	([141.3.12.100] helo=studsun1 ident=exim)
	by irams1.ira.uka.de with esmtp (Exim 3.30 #7 (Debian))
	id 17FWRm-0002L7-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2002 10:47:14 +0200
Received: from s_schrem by studsun1 with local (Exim 3.30 #7 (Debian))
	id 17FWRl-0006wB-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2002 10:47:13 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm just starting to write a Driver for a Sound card (first time for me!)

Problem is, that when I include the Headerfile (sound/driver.h,
sound/control.h, ...) I get a lot of parse errors from them!

I already updated to the latest packages from Takashi's Server but that
didn't change anything :-(

Does this have to do with problem mentioned before about the wrong
headerfiles? But why should this cause parse errors?

What is the best way to develop drivers under SuSE?
Can I use the RPMs or must I compile everything by hand?

Greetings to all
Oli


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
