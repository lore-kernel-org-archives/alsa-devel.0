From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Can't build alsa-driver git, missing isa/wss directory.
Date: Fri, 08 Aug 2008 10:04:58 +1200
Message-ID: <200808081004.58889.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id AC56E249B0
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 00:05:04 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K59006MJ40B62EL@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 08 Aug 2008 10:05:01 +1200 (NZST)
Content-disposition: inline
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

after recent git-pull of alsa-kmirror, I can no longer build alsa-driver

Seems the isa/wss (present in alsa-kmirror) directory is missing from 
alsa-driver?

regards

--
Eliot Blennerhassett
www.audioscience.com
