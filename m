From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Cross compiling alsa-lib
Date: Thu, 3 Jan 2008 22:20:16 +0000
Message-ID: <8b67d60801031420g395102adkd24edc09e9774179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B19510385F
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 23:20:18 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 55so286334wri.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2008 14:20:17 -0800 (PST)
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

Is there anyone here able to give a canonical statement on how to
configure alsa-lib for a cross compiled build linked to uclibc?

I think the issue may be getting the path right for the libraries on
the host machine.
