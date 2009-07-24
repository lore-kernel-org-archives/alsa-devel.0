From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: get two mono channel from stereo line
Date: Fri, 24 Jul 2009 11:07:24 +0700
Message-ID: <c697747b0907232107k749c413bx2a88ccc97505447b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F9DE103A41
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 06:07:26 +0200 (CEST)
Received: by gxk7 with SMTP id 7so2367438gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 21:07:25 -0700 (PDT)
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

Hi,

We have a beagleboard with one audio line-in and one audio line-out. From
the documentation both are stereo line. Now we want to use four mono audio
line for our system. two input from radio and microphone, two output to
radio and speaker. We use ALSA and we would like to know how we can achieve
this either by plugin or programming alsa.

Thank you for your help

Arif
