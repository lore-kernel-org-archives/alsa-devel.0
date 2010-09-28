From: Michael Niemeck <michael@niemeck.org>
Subject: TASCAM US-144mkII Driver
Date: Tue, 28 Sep 2010 08:59:54 +0200
Message-ID: <20100928085954.729252qribunofb4@secure.niemeck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alpha.niemeck.net (alpha.niemeck.net [213.208.138.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 3230D103883
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 09:00:10 +0200 (CEST)
Received: from alpha.niemeck.net (localhost [127.0.0.1])
	by alpha.niemeck.net (8.14.3/8.14.3) with ESMTP id o8S6xtag029602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2010 08:59:55 +0200
Received: (from apache@localhost)
	by alpha.niemeck.net (8.14.3/8.14.3/Submit) id o8S6xsBd029601
	for alsa-devel@alsa-project.org; Tue, 28 Sep 2010 08:59:54 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Common consensus in the forums seems to be that the mkII versions of  
the TASCAM 122 and 144 have different hard- and/or software than their  
respective predecessors, and won't work with the current ALSA drivers.  
At least the latter I can confirm for my US-144mkII. Lacking the  
resources to modify the existing driver to work with the above  
interface, let alone write a new one, I wanted to ask if anyone of the  
active ALSA developers would be willing to (or is even already in the  
process of) write or modify a driver for the new TASCAMs. I would be  
more than willing to contribute to a bounty, if such a thing is common  
or at least accepted in the ALSA community, and according to this post  
(http://article.gmane.org/gmane.linux.alsa.user/34586) TASCAM is ready  
to support such a project with demo units. I would also be willing to  
function as a tester, of course.

Still hoping,

Mike

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
