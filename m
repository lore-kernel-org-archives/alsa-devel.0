From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Wall clock interrrupts
Date: Fri, 25 Jan 2008 17:38:53 +1100
Message-ID: <479983FD.5040704@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id D8DC9246F6
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 07:38:40 +0100 (CET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[127.0.0.1])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1JIID1-0005JQ-PQ
	for alsa-devel@alsa-project.org; Fri, 25 Jan 2008 06:38:40 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Do all sound cards hardware have wall clocks that one can generate 
interrupts from?
I know all Creative and E-Mu cards do.
I am looking to use the wall clock interrupt for triggering events in 
application space, but would like to know what other sound cards support it.

James
