From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Re: Echo driver
Date: Mon, 08 Nov 2004 09:29:07 +0100 (CET)
Message-ID: <XFMail.20041108092907.pochini@shiny.it>
References: <20041107185230.M12281@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041107185230.M12281@stickist.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yon Mercury <swirlee@stickist.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 07-Nov-2004 Yon Mercury wrote:
>> Giuliano Pochini <pochini@shiny.it> wrote:
>> Perhaps I'll put the driver in bugfixes-only state because it's very
>> stable and ready for production for a long time now and because
>> Echoaudio has just released a new version of their generic code that
>> support all cards and I want to start working of it ASAP. There are
>> several changes to the DSP firmware that may cause incompatibilities
>> with the current driver (maybe not, I only had a look at the notes).
>
> So Echo released the new driver they have been promising?

Yes: http://www.echoaudio.com/Downloads/license_agreement.php
and I already started to work on it. The new firmware
has some differences on almost all cards, so I have to
change the code for old cards too.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
