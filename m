From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Issues with ATI IXP SB4x0
Date: Fri, 23 Jul 2010 02:24:02 +0300
Message-ID: <AANLkTimlU5yWPMoeP3GS6Nu4tX7pox-RTC-vM8ucJk37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC3710380D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 01:24:22 +0200 (CEST)
Received: by wyb42 with SMTP id 42so1071125wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 16:24:22 -0700 (PDT)
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

An Acer laptop with the ATI IXP SB4x0 chipset fails to detect the audio card.
Here is the alsa-info file with latest Alsa,
http://www.alsa-project.org/db/?f=b63339af32dd301eba9f5ef6a0787ccfbeb55778

What should be the next thing to try in order to solve this issue?
The "Conexant ID 2c06" string in the file appears to refer to the modem (?).
Googling with the subsystem ID '1025:009f only brings cases where the
sound does not work.
Any suggestions on where to look at?

Simos
