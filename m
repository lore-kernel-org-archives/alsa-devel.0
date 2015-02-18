From: Misan Thropos <misanthropos@gmx.de>
Subject: Correct 5.1 settings for Asus mobo AT4NM10-I with IDT
	92HD73C1X5
Date: Wed, 18 Feb 2015 23:19:58 +0100
Message-ID: <20150218231958.0fd68009@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BA0C260470
 for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2015 23:20:01 +0100 (CET)
Received: from atomix.home.lan ([84.59.134.106]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Lh7M3-1XjwsZ2jP5-00oVHy for
 <alsa-devel@alsa-project.org>; Wed, 18 Feb 2015 23:20:00 +0100
Received: from bugger.home.lan ([172.20.1.11] helo=localhost)
 by atomix.home.lan with esmtp (Exim 4.84)
 (envelope-from <misanthropos@gmx.de>) id 1YOCyL-0001Yb-C4
 for alsa-devel@alsa-project.org; Wed, 18 Feb 2015 23:19:57 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I got it to work with the help of "debianuser" on #alsa@freenode and
hdajackretask which can be found in alsa-tools-gui (if you use Debian).

Had to change some pin settings from default configuration to make it
work. You can get the working configuration from:

http://www.alsa-project.org/db/?f=71b06cd49f390e0ff4061d069a2efcb93b3148d2

It enables the S/PDIF digital output too.


Maybe you like to take that information for a model for IDT
92HD73C1X5.


cheers,
Misan
