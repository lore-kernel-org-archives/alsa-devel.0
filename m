From: Massimiliano Cialdi <massimiliano.cialdi@powersoft.it>
Subject: runtime change in plugin behaviour
Date: Thu, 24 May 2012 16:58:36 +0200
Message-ID: <4FBE4C9C.2030604@powersoft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.powersoft.it (mail1.powersoft.it [188.219.163.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 9621B24156
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 16:58:39 +0200 (CEST)
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

I have developed a plugin that implements a bi-quad filter. filter's 
parameters are given into asoundrc file.

Now I need to change those parameters during playback.
How can I do?
what help can gives alsalib to achieve this?

best regards

Max
