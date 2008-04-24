From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: how to disable mmap and allow .copy function to be
	called
Date: Thu, 24 Apr 2008 09:59:50 +0530
Message-ID: <827ad74d0804232129s4f52bbe3g2861acc6ddc778ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E62E724405
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 06:29:51 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so824784ana.80
	for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2008 21:29:50 -0700 (PDT)
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
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Can anyone help me - I need to modify an existing driver such that a new
.copy function is invoked. how to make sure that mmap is diabled?

Thanks,
Harsha
