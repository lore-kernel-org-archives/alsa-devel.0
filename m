From: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Subject: Re: Underrun on Jade controller...
Date: Fri, 23 Nov 2012 04:54:22 -0800 (PST)
Message-ID: <1353675262.71605.YahooMailNeo@web120405.mail.ne1.yahoo.com>
References: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
 <50AF4B3E.9050003@gmail.com>
 <1353666946.95213.YahooMailNeo@web120406.mail.ne1.yahoo.com>
 <50AF527C.8000108@gmail.com>
Reply-To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm38-vm7.bullet.mail.ne1.yahoo.com
 (nm38-vm7.bullet.mail.ne1.yahoo.com [98.138.229.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CEFE261647
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 13:54:24 +0100 (CET)
In-Reply-To: <50AF527C.8000108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> On 23.11.2012 11:35, Sandulescu Bogdan wrote:
> > =

> > Daniel Mack <zonque <at> gmail.com> writes:
> >>
> >> Without providing any code, I guess nobody on this list will be able to
> >> help you.
> >>
> >> Daniel
> >>
> > =

> > =

> > OK. Here is the essential part of my code - settings and write to ALSA:
> =

> It's not about the userspace code in the first place but the kernel part.
> =

> I guess you are based on a BSP kernel that the vendor of the
> chip/module/board you are using provides. For whatever reason, this
> vendor has decided to not push its code to the mainline kernel but keep
> changes in a private repository.
> =

> While this is a common approach, your vendor is the only instance in the
> game that is in charge of supporting you here. The community can't, as
> the code has not been shared for discussion and integration in mainline.
> =

> Daniel
> =

> =



Hello Daniel,

Thank you for your answer. Initially I thought I should share my app, as ev=
ery information I got regarding underruns was that the application is not f=
eeding data fast enough - hence I thought it was my application's fault.

Considering your precise answer, I will try to get support directly from th=
e module vendor.

Yours,
=A0=A0=A0 Bogdan
