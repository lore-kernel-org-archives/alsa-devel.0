From: Andre Kirchner <supercroc1974@yahoo.com>
Subject: How to find out which PCM handle ASCII identifier to
	pass to snd_pcm_open?
Date: Sun, 21 Sep 2008 12:33:37 -0700 (PDT)
Message-ID: <646076.37056.qm@web51803.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web51803.mail.re2.yahoo.com (web51803.mail.re2.yahoo.com
	[206.190.38.234]) by alsa0.perex.cz (Postfix) with SMTP id CB46724149
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Sep 2008 21:33:38 +0200 (CEST)
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

I have just started learning ALSA's api, and came accross some examples at http://equalarea.com/paul/alsa-audio.html, which pass argv[1] to snd_pcm_open.

My question is which should be the values of argv[1] for the microphone, and left and right speakers devices?

I'm not sure this is the right mailing list for this question, and I apologize if not :-)

Thanks,

Andre
