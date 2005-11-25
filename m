From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Modem support for ICH6 based laptop?
Date: Fri, 25 Nov 2005 15:13:37 +0200
Message-ID: <20051125131337.GA14453@tecr>
References: <1132791202.32481.22.camel@SillyPuddy.localdomain> <20051124030116.GB6056@tecr> <1132913421.10774.32.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1132913421.10774.32.camel@SillyPuddy.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Josh Green <josh@resonance.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02:10 Fri 25 Nov     , Josh Green wrote:
> 
> $ cat /proc/asound/card0/codec#1
> 
> Codec: Generic 14f1 ID 2bfa
> Address: 1
> Vendor Id: 0x14f12bfa
> Subsystem Id: 0x0
> Revision Id: 0x90000

It is Conexant's (0x14f1) HDA modem codec. Unfortunately it is
unsupported.

Sasha.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
