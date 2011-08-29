From: Touko Korpela <touko.korpela@iki.fi>
Subject: Problem with sound on Asus EeePC 1215b
Date: Mon, 29 Aug 2011 14:50:05 +0300
Message-ID: <20110829115005.GA2937@lisko>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133]) by alsa0.perex.cz (Postfix) with ESMTP id 0009D24680
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 13:49:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 686A03F9EE
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 14:49:42 +0300 (EEST)
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva,
	port 10041)
	with ESMTP id M5QfZIkw89KO for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 14:49:41 +0300 (EEST)
Received: from luumupuu.dnainternet.net (luumupuu.dnainternet.net
	[83.102.40.213])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id C4E1B3F8C2
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 14:49:41 +0300 (EEST)
Received: from lisko (81-175-159-134.bb.dnainternet.fi [81.175.159.134])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by luumupuu.dnainternet.net (Postfix) with ESMTPS id AABDB2BADD
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 14:49:40 +0300 (EEST)
Received: from touko by lisko with local (Exim 4.72)
	(envelope-from <touko.korpela@iki.fi>) id 1Qy0Lt-0000mT-K0
	for alsa-devel@alsa-project.org; Mon, 29 Aug 2011 14:50:05 +0300
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

(I had to subscribe to this list, otherwise mails seem to stuck forever,
moderation doesn't seem to work. But please reply to me directly, I don't
receive messages sent to the list, because I disabled that in settings)

Your bug tracker is useless now, because driver maintainers don't use it.
It's not nice to report bugs there if nobody reads them.

www.alsa-project.org /db/?f=e13caeff15a01968117053a7c7fe9588715aec8b

Support for this hardware seem to have some issues.
No sound is heard (but mixer is not muted).
Shouldn't mixer have more channels to adjust?
Linux kernel version is 3.0.0-1-amd64 (Debian 3.0.0-3), containing upstream
3.0.3
