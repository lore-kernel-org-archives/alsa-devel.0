From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: How to send control codes to a USB device?
Date: Fri, 5 Jun 2009 11:36:57 +0200
Message-ID: <d9690f190906050236m7ede411ft19cf7db04caec8ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2496F2463B
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 11:36:57 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so710798ywq.2
	for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2009 02:36:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there.

Is there a way to sent control codes to a USB device, without using a
specific driver .

I would like to try to set latency and output modes of my M-Audio Transit by
sending a control code as additional part of the UDEV madfuload firmware
initialzation.

How can I do something like that?

If this works in general I just need to figure out the required control
codes.


THX for your support
Klaus
