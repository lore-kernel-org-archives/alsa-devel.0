From: <Mario_Limonciello@Dell.com>
Subject: RE: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Fri, 22 May 2015 16:19:05 -0500
Message-ID: <DB6E482E89290547898851B8CC9D8110016A5EBC17@AUSX7MCPS302.AMER.DELL.COM>
References: <20150517174144.GA17503@light.dominikbrodowski.net>
 <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
 <555E2184.3090900@dell.com> <2098590.Jj0ekzOVtF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2098590.Jj0ekzOVtF@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: matthew.garrett@coreos.com, linux@dominikbrodowski.net, linux-acpi@vger.kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> OK, so do we have any proof that anything in addition to the sound thing is broken by returning 2 from _REV?
> 
> If not, then we're probably spending too much time discussing this.

>From a Dell perspective I'm not aware of anything else breaking, but I'll be sure to raise its attention and any associated details if I become privy to them.  I'm working with architecture to ensure that future products are not relying on _REV values as well.
I know Matthew had mentioned that another OEM's product was using this as well, but I don't know what for.

