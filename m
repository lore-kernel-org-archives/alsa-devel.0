From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Streams
Date: Wed, 17 Dec 2008 11:16:28 +0000
Message-ID: <4948DF8C.40900@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lon1-post-3.mail.demon.net (lon1-post-3.mail.demon.net
	[195.173.77.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B131037EC
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 12:16:31 +0100 (CET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1LCuOE-0004GY-dA
	for alsa-devel@alsa-project.org; Wed, 17 Dec 2008 11:16:30 +0000
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

There was some talk some time ago of maybe moving alsa to a streams
approach instead of ring buffer and periods approach.
Has anything become of this?
Is there a plan to improve the abstraction between hardware and user
space regarding constraints on period sizes when doing sample rate
conversion?

Kind Regards

James
