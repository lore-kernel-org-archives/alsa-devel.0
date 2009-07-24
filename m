From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: get two mono channel from stereo line
Date: Fri, 24 Jul 2009 13:05:01 +0700
Message-ID: <c697747b0907232305se5f64a8o3e3ffec647dd99b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E19103A51
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 08:05:02 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so803070anc.2
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 23:05:01 -0700 (PDT)
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
