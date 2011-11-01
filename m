From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Tue, 01 Nov 2011 11:25:35 +0100
Message-ID: <4EAFC91F.5060408@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<4EAE96BC.6060605@gmail.com>
	<CAE-xCyPKy2JTXPPDLsn99YWa1D5XUtjzUX2PxjQ8VvH-h=7Fpw@mail.gmail.com>
	<4EAFB89F.5050704@gmail.com>
	<CAFz=ag6duH7H64J_J8EiwHaSg3G02gb8_qQ3mJK8Xi5iveBpmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9C79C24367
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 11:56:40 +0100 (CET)
Received: by faao24 with SMTP id o24so7023542faa.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2011 03:56:38 -0700 (PDT)
In-Reply-To: <CAFz=ag6duH7H64J_J8EiwHaSg3G02gb8_qQ3mJK8Xi5iveBpmQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/01/2011 10:40 AM, Felix Homann wrote:
> Hi Daniel,
>
> that's great news indeed!
>
>> No, go ahead and test. Be warned that your machine might still lock up,
>> but any kind of feedback is certainly valuable.
>
> Would you mind sending a single diff as an attachment for us simple testers?
> (I'm reading this list in a web interface only and had several
> problems with copy and pasting inlined patches in the past.)

Here you go:

   https://gist.github.com/1168715


Daniel
