From: Gabriel Johnson <johnsoga@gmail.com>
Subject: Adding MMAP support to alsa driver
Date: Thu, 30 Apr 2009 15:51:33 -0500
Message-ID: <bb6204720904301351t99fc7ev36d0ecf34798b0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 689F624702
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 22:51:34 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1335825ywq.2
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2009 13:51:33 -0700 (PDT)
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

What structures need to be filled out in the hardware driver to
support MMAP calls?
