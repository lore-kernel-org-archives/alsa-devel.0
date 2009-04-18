From: reetesh chandran <reeteshchandran@yahoo.com>
Subject: how to find the last plugged in USB headset ?
Date: Sat, 18 Apr 2009 09:26:46 -0700 (PDT)
Message-ID: <765681.23349.qm@web30007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web30007.mail.mud.yahoo.com (web30007.mail.mud.yahoo.com
	[209.191.69.24]) by alsa0.perex.cz (Postfix) with SMTP id 7F08C244AB
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Apr 2009 18:26:48 +0200 (CEST)
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

Hi all,

Is there a way to find the card number associated with the USB headset that was plugged in last. I am listening to udev events and I can find the card number by comparing the VendorId product Id combination. But if there are multiple devices of same VendorId and productId, how do I find the card number associated with the device that was plugged in the last ?

Thanks in advance ?
Reetesh
