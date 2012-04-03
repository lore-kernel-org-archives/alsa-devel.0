From: jarek <jarek@poczta.srv.pl>
Subject: Alsa soc UDA1380 - no duplex
Date: Tue, 03 Apr 2012 11:34:01 +0200
Message-ID: <1333445641.7330.59.camel@jlap2.macro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.srv.pl (mail.srv.pl [217.17.32.250])
	by alsa0.perex.cz (Postfix) with ESMTP id E72A0104135
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 11:28:29 +0200 (CEST)
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

Hello!

	I've received information from lpclinux.com that uda1380 on lpc313x
doesn't support duplex.
	I've got some information that uda1380 on s3c24xx works with duplex, so
I think, that it should work also on lpc313x. I'm ready to write some
code, but I have no experience with ALSA, so I'll be happy if someone
will give me some hints where to start.
	The other question is why there are two drivers to the same device.

best regards
Jarek
