From: "John Kacur" <jkacur@gmail.com>
Subject: Where are dma interrupts handled in ASoC code?
Date: Fri, 21 Nov 2008 10:45:46 +0100
Message-ID: <520f0cf10811210145i20dec91ax9508b9268136bd5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B92D243D1
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 10:45:47 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so840702rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 01:45:46 -0800 (PST)
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

Where are dma overflow interrupts handled? For example I don't see
this in sound/soc/s3c24xx-i2s.c

Thanks
