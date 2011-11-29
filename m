From: Daniel Mack <zonque@gmail.com>
Subject: Re: MAYA44 USB audio device no inputs control
Date: Tue, 29 Nov 2011 08:59:27 +0100
Message-ID: <4ED490DF.60706@gmail.com>
References: <CAB+hzYRC+_RDBwiakNq7PJ=_7xyrFhTdNuoYAGyyq093s0mp0A@mail.gmail.com>
	<4ECBCF52.8020907@gmail.com>
	<CAB+hzYS7KEH1P3uWWw63YXFck16CeG8SHtOb7wo82Wu0fL+VDA@mail.gmail.com>
	<CAB+hzYR+5kCh-76U=K+Vvsm+Kj74dfJ=N__JcJsCpg2W9WiWLQ@mail.gmail.com>
	<4ECCA941.9020403@ladisch.de>
	<CAB+hzYTFuVJdDkySwAH52xUmgwqB4bgRdK1Q3kTnpiZHBerVvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 50951103835
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 08:59:31 +0100 (CET)
Received: by bkat8 with SMTP id t8so8789909bka.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 23:59:31 -0800 (PST)
In-Reply-To: <CAB+hzYTFuVJdDkySwAH52xUmgwqB4bgRdK1Q3kTnpiZHBerVvA@mail.gmail.com>
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

On 11/29/2011 08:40 AM, Kamil Sobolak wrote:
> I attached screenshot with output control levels.

That doesn't show the capture controls. Please do as Clemens suggested
and paste the outputs of "axmixer contents".

> Where can I find error messages?

Use the "dmesg" command.


Thanks,
Daniel
