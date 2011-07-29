From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Fri, 29 Jul 2011 18:34:01 +0200
Message-ID: <4E32E0F9.6060906@ladisch.de>
References: <CAB+ez9uWAFcL_K353Q5BCYj4AAF051a=SQU++BQ5ygV+SnqDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 92BE21037FF
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 18:30:24 +0200 (CEST)
In-Reply-To: <CAB+ez9uWAFcL_K353Q5BCYj4AAF051a=SQU++BQ5ygV+SnqDjQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

`/ET!-i1S!-i wrote:
> Actually i need to stream the audio data  to other system through kernel
> socket.

Why aren't you using PulseAudio?


Regards,
Clemens
